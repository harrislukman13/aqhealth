import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  String? appointmentid;
  String? bookdate;
  int? time;
  String? doctorid;
  String? doctorname;
  String? patientname;
  String? patientID;
  String? specialistname;
  String? status;

  Appointment(
      {this.appointmentid,
      this.bookdate,
      this.doctorname,
      this.time,
      this.patientID,
      this.specialistname,
      this.doctorid,
      this.patientname,
      this.status});

  factory Appointment.fromFireStore(DocumentSnapshot doc) {
    return Appointment(
        appointmentid: doc['appointmentid'],
        bookdate: doc['bookdate'],
        doctorid: doc['doctorid'],
        doctorname: doc['doctorname'],
        specialistname: doc['specialistname'],
        time: doc['time'],
        patientID: doc['patientid'],
        patientname: doc['patientname'],
        status: doc['status']);
  }
}
