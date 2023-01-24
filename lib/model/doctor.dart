import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  String? doctorID;
  String? doctorName;
  String? specialistId;
  String? description;
  String? specialistname;
  int? startTime;
  int? endTime;
  String? url;

  Doctor(
      {this.doctorID,
      this.doctorName,
      this.specialistId,
      this.description,
      this.specialistname,
      this.startTime,
      this.endTime,
      this.url});

  factory Doctor.fromFireStore(DocumentSnapshot doc) {
    return Doctor(
        doctorID: doc['id'],
        doctorName: doc['doctorname'],
        specialistId: doc['specialistid'],
        specialistname: doc['specialistname'],
        description: doc['description'],
        startTime: doc['starttime'],
        endTime: doc['endtime'],
        url: doc['url']);
  }
}
