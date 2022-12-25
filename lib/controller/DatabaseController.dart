import 'package:aqhealth/model/doctor.dart';
import 'package:aqhealth/model/patient.dart';
import 'package:aqhealth/model/specialist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class DatabaseController {
  final String uid;
  DatabaseController({required this.uid});
  DatabaseController.withoutUID() : uid = "";

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future updateUserData(Patient a) async {
    dynamic data;
    try {
      data = userCollection.doc(uid).set({
        'name': a.name,
        'role': a.role,
        'phone': a.phonenum,
        'ic': a.ic,
        'gender': a.gender,
        'address': a.address,
        'state': a.state
      });

      data = _db.collection('Patient').doc(uid).set({
        'name': a.name,
        'role': a.role,
        'phone': a.phonenum,
        'ic': a.ic,
        'gender': a.gender,
        'address': a.address,
        'state': a.state
      });
    } catch (e) {
      print(e.toString());
    }
    return data;
  }

  //get specialist
  Stream<List<Specialist>> getSpecialist() {
    return _db.collection('Specialist').snapshots().map((list) => list.docs
        .map((specialist) => Specialist.fromFireStore(specialist))
        .toList());
  }

  // getdoctor specialist
  Future<List<Doctor>> getDoctor(String specialistId) async {
    QuerySnapshot<Map<String, dynamic>> data = await _db
        .collection('Doctor')
        .where('specialistid', isEqualTo: specialistId)
        .get();
    List<Doctor> doctors =
        data.docs.map((doc) => Doctor.fromFireStore(doc)).toList();
    return doctors;
  }

  Stream<List<Patient>> getPatient() {
    return _db.collection('Patient').snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Patient.fromFireStore(doc, userId: uid))
        .toList());
  }
}
