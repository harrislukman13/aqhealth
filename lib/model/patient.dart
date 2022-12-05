import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;

  UserModel({required this.uid});
}

class Patient {
  String? id;
  String? name;
  String? role;
  String? phonenum;
  String? ic;
  String? address;
  String? gender;
  String? state;

  Patient(
      {this.id,
      this.name,
      this.role,
      this.phonenum,
      this.gender,
      this.ic,
      this.address,
      this.state});

  factory Patient.fromFireStore(DocumentSnapshot doc, {String userId = ''}) {
    return Patient(
        id: userId,
        name: doc['name'],
        role: doc['role'],
        phonenum: doc['phonenum'],
        gender: doc['gender'],
        ic: doc['ic'],
        address: doc['address'],
        state: doc['state']);
  }
}
