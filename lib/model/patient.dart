
class Patient {
  String? id;
  String? name;
  String? email;

  Patient({
    this.id,
    this.name,
    this.email,
  });

  factory Patient.fromMap(Map<String, dynamic> map) => Patient(
        id: map['id'].toString(),
        name: map['name'],
        email: map['email'],
      );
}
