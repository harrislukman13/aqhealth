import 'package:aqhealth/model/doctor.dart';
import 'package:aqhealth/model/patient.dart';
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
  Future<List<String>> getSpecialist(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> data =
          await _db.collection('Specialist').doc(id).get();
      List<dynamic> datas = data['specialist_name'];
      List<String> specialists = [];
      for (var element in datas) {
        specialists.add(element.toString());
      }
      return specialists;
    } catch (e) {
      print('error');
      return [];
    }
  }

  // getdoctor specialist
  Future<Iterable<Doctor>> getDoctor(String specialistId) async {
    QuerySnapshot<Map<String, dynamic>> data = await _db
        .collection('Doctor')
        .where('Specialist', isEqualTo: specialistId)
        .get();
    Iterable<Doctor> doctors =
        data.docs.map((doc) => Doctor.fromFireStore(doc));
    return doctors;
  }

  
}
