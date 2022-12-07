import 'package:cloud_firestore/cloud_firestore.dart';

class Specialist {
  final String? id;
  final String? specialist_name;

  Specialist({
    this.id,
    this.specialist_name,
  });

  factory Specialist.fromFireStore(DocumentSnapshot doc) {
    return Specialist(id: doc['id'], specialist_name: doc['specialist_name']);
  }
}
