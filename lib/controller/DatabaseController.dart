import 'dart:developer';

import 'package:aqhealth/model/appoinment.dart';
import 'package:aqhealth/model/doctor.dart';
import 'package:aqhealth/model/notification.dart';
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
        'state': a.state,
        'url': a.url
      });

      data = _db.collection('Patient').doc(uid).set({
        'name': a.name,
        'role': a.role,
        'phone': a.phonenum,
        'ic': a.ic,
        'gender': a.gender,
        'address': a.address,
        'state': a.state,
        'url': a.url
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

  Future<List<Appointment>> getAppointmentAvailability() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await _db.collection('Appointment').get();
    List<Appointment> appointmets =
        data.docs.map((doc) => Appointment.fromFireStore(doc)).toList();
    return appointmets;
  }

  Future<List<Appointment>> getAppointment(String uid) async {
    QuerySnapshot<Map<String, dynamic>> data = await _db
        .collection('Appointment')
        .where('patientid', isEqualTo: uid)
        .get();
    List<Appointment> appointments =
        data.docs.map((doc) => Appointment.fromFireStore(doc)).toList();
    return appointments;
  }

  Future getSingleAppointment(String appointmentid) async {
    var data = await _db.collection('Appointment').doc(appointmentid).get();
    if (data.exists) {
      Map<String, dynamic>? appointment = data.data();
      return appointment;
    }
  }

  Future getSingleDoctor(String doctorId) async {
    var data = await _db.collection('Doctor').doc(doctorId).get();
    if (data.exists) {
      Map<String, dynamic>? doctor = data.data();
      return doctor;
    }
  }

  Future<List<Appointment>> getLatestApointment(String uid) async {
    QuerySnapshot<Map<String, dynamic>> data = await _db
        .collection('Appointment')
        .where('status', isEqualTo: 'success')
        .where('patientid', isEqualTo: uid)
        .get();
    List<Appointment> appointments =
        data.docs.map((doc) => Appointment.fromFireStore(doc)).toList();
    return appointments;
  }

  Future<List<Appointment>> getHistoryApointment(String uid) async {
    QuerySnapshot<Map<String, dynamic>> data = await _db
        .collection('Appointment')
        .where('status', isEqualTo: 'completed')
        .where('patientid', isEqualTo: uid)
        .get();
    List<Appointment> appointments =
        data.docs.map((doc) => Appointment.fromFireStore(doc)).toList();
    return appointments;
  }

  Future<List<Notifications>> getNotification(String uid) async {
    QuerySnapshot<Map<String, dynamic>> data =
        await _db.collection('Notification').where('id', isEqualTo: uid).get();
    List<Notifications> notifications =
        data.docs.map((doc) => Notifications.fromFireStore(doc)).toList();
    return notifications;
  }

  Future<bool> createAppointment(
    Appointment a,
  ) async {
    try {
      await _db.collection('Appointment').doc(a.appointmentid).set({
        "appointmentid": a.appointmentid,
        "doctorname": a.doctorname,
        "bookdate": a.bookdate,
        "time": a.time,
        "patientid": a.patientID,
        "patientname": a.patientname,
        "doctorid": a.doctorid,
        "specialistname": a.specialistname,
        "status": a.status,
        'url': a.docURL
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updatePatient(Patient a, String uid) async {
    try {
      await _db.collection('User').doc(uid).update({
        'name': a.name,
        'gender': a.gender,
        'ic': a.ic,
        'phone': a.phonenum,
        'role': a.role,
        'state': a.state,
        'url': a.url,
        'address': a.address
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateAppointment(Appointment a) async {
    try {
      await _db.collection('Appointment').doc(a.appointmentid).update({
        'appointmentid': a.appointmentid,
        'bookdate': a.bookdate,
        'doctorid': a.doctorid,
        'doctorname': a.doctorname,
        'patientid': a.patientID,
        'patientname': a.patientname,
        'specialistname': a.specialistname,
        'status': a.status,
        'time': a.time,
        'url': a.docURL,
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteAppointment(String id) async {
    await _db.collection('Appointment').doc(id).delete();
  }
}
