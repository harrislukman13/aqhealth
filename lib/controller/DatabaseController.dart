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
}
