import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {
  String? id;
  String? doctorName;
  String? specialistId;
  String? description;

  Doctor({this.id, this.doctorName, this.specialistId, this.description});

  factory Doctor.fromFireStore(DocumentSnapshot doc) {
    return Doctor(
        id: doc['id'],
        doctorName: doc['doctorName'],
        specialistId: doc['specialistId'],
        description: doc['decription']);
  }
}
