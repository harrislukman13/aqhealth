import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  String id;
  String doctorName;
  String specialistId;
  String description;
  String specialistname;

  Doctor(
      {required this.id,
      required this.doctorName,
      required this.specialistId,
      required this.description,
      required this.specialistname});

  factory Doctor.fromFireStore(DocumentSnapshot doc) {
    return Doctor(
        id: doc['id'],
        doctorName: doc['doctorname'],
        specialistId: doc['specialistid'],
        specialistname: doc['specialistname'],
        description: doc['description']);
  }
}
