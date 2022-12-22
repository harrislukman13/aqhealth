import 'package:cloud_firestore/cloud_firestore.dart';


class Appointment {
  String? id;
  //@JsonKey(fromJson: AppUtil.timeStampToDateTime, toJson: AppUtil.dateTimeToTimeStamp);
  DateTime? dateStart;
  DateTime? dateEnd;
  String? doctorId;
  String? patientID;
  String? specialistID;

  Appointment(
      {this.id,
      this.dateStart,
      this.dateEnd,
      this.doctorId,
      this.patientID,
      this.specialistID});

  factory Appointment.fromFireStore(DocumentSnapshot doc) {
    return Appointment(
      id: doc['id'],
      dateStart: doc['dateStart'],
      dateEnd: doc['dateEnd'],
      doctorId: doc['doctorId'],
      patientID: doc['patientId'],
      specialistID: doc['specialistId'],
    );
  }
}
